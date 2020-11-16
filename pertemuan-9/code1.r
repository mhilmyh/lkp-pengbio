# Muhamad Hilmy Haidar
# install.packages("protr")
# install.packages("dplyr")

library("dplyr")
library("devtools")
library("protr")

folder_name <- "dataset01"
fasta_files <- list.files(folder_name)
col_label <- c("A","R","N","D","C","E","Q","G","H","I","L","K","M","F","P","S","T","W","Y","V")

# Fungsi untuk ekstrak fitur
extract_feature <- function(fasta_path) {
  fasta_file <- readFASTA(fasta_path)[[1]]
  extracted <- extractAAC(fasta_file)
  return(extracted)
}

extract_all_feature <- function(array_files) {
  result <- matrix(nrow = length(array_files), ncol = 20)
  
  for(i in seq_along(array_files)) {
    v <- extract_feature(paste(folder_name, array_files[i], sep = "/"))
    for(j in 1:20) {
      result[i, j] = v[i]
    }
  }
  colnames(result) <- col_label
  return(data.frame(result))
}

# Fungsi klasterisasi
do_clustering <- function(df, method, metric, k) {
  d <- dist(df, method = metric)
  res_tree <- hclust(d, method = method)
  
  # Menggambarkan dendogram
  plot(res_tree)
  title(main = paste("\t\t\t\t\t\t\t",method, sep = " "))
  rect.hclust(res_tree, k = k)
  
  cut_tree <- cutree(res_tree, k = k)
  return(cut_tree)
}

# Fungsi untuk membuat kontingensi tabel
contingency_table <- function(cut_cluster, df, lbl) {
  seeds_df_cl <- mutate(df, cluster = cut_cluster)
  ctd_table <- table(seeds_df_cl$cluster, t(lbl))
  print(count(seeds_df_cl, cluster))
  print(ctd_table)
  return(ctd_table)
}

# Fungsi untuk menghitung purity
purity_value <- function(table, df){
  mat_sum = 0
  for (i in 1:nrow(table))
    mat_sum = mat_sum + max(table[i,])
  return(mat_sum/nrow(df))
}

# Membuat matrix
res_mtx = extract_all_feature(fasta_files)

# Analisis cluster dengan complete linkage
res_cut_comp = do_clustering(res_mtx, "complete", "euclidean", 3)
res_ct_comp = contingency_table(res_cut_comp, res_mtx, fasta_files[1:15]))
res_comp = purity_value(res_ct_comp, res_mtx)
print(res_comp)

# Analisis cluster dengan centroid linkage
res_cut_centr = do_clustering(res_mtx, "centroid", "euclidean", 3)
res_ct_centr = contingency_table(res_cut_centr, res_mtx, fasta_files[1:15])
res_centr = purity_value(res_ct_centr, res_mtx)
print(res_centr)