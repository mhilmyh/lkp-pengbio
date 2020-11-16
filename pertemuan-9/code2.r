# install.packages("protr")
# install.packages("dplyr")

library("dplyr")
library("devtools")
library("protr")

folder_name <- "dataset02"
csv_files <- list.files(folder_name)
col_label <- c(
  "MACCSFP1",
  "MACCSFP2",
  "MACCSFP3",
  "MACCSFP4",
  "MACCSFP5",
  "MACCSFP6",
  "MACCSFP7",
  "MACCSFP8",
  "MACCSFP9",
  "MACCSFP10",
  "MACCSFP11",
  "MACCSFP12",
  "MACCSFP13",
  "MACCSFP14",
  "MACCSFP15",
  "MACCSFP16",
  "MACCSFP17",
  "MACCSFP18",
  "MACCSFP19",
  "MACCSFP20",
  "MACCSFP21",
  "MACCSFP22",
  "MACCSFP23",
  "MACCSFP24",
  "MACCSFP25",
  "MACCSFP26",
  "MACCSFP27",
  "MACCSFP28",
  "MACCSFP29",
  "MACCSFP30",
  "MACCSFP31",
  "MACCSFP32",
  "MACCSFP33",
  "MACCSFP34",
  "MACCSFP35",
  "MACCSFP36",
  "MACCSFP37",
  "MACCSFP38",
  "MACCSFP39",
  "MACCSFP40",
  "MACCSFP41",
  "MACCSFP42",
  "MACCSFP43",
  "MACCSFP44",
  "MACCSFP45",
  "MACCSFP46",
  "MACCSFP47",
  "MACCSFP48",
  "MACCSFP49",
  "MACCSFP50",
  "MACCSFP51",
  "MACCSFP52",
  "MACCSFP53",
  "MACCSFP54",
  "MACCSFP55",
  "MACCSFP56",
  "MACCSFP57",
  "MACCSFP58",
  "MACCSFP59",
  "MACCSFP60",
  "MACCSFP61",
  "MACCSFP62",
  "MACCSFP63",
  "MACCSFP64",
  "MACCSFP65",
  "MACCSFP66",
  "MACCSFP67",
  "MACCSFP68",
  "MACCSFP69",
  "MACCSFP70",
  "MACCSFP71",
  "MACCSFP72",
  "MACCSFP73",
  "MACCSFP74",
  "MACCSFP75",
  "MACCSFP76",
  "MACCSFP77",
  "MACCSFP78",
  "MACCSFP79",
  "MACCSFP80",
  "MACCSFP81",
  "MACCSFP82",
  "MACCSFP83",
  "MACCSFP84",
  "MACCSFP85",
  "MACCSFP86",
  "MACCSFP87",
  "MACCSFP88",
  "MACCSFP89",
  "MACCSFP90",
  "MACCSFP91",
  "MACCSFP92",
  "MACCSFP93",
  "MACCSFP94",
  "MACCSFP95",
  "MACCSFP96",
  "MACCSFP97",
  "MACCSFP98",
  "MACCSFP99",
  "MACCSFP100",
  "MACCSFP101",
  "MACCSFP102",
  "MACCSFP103",
  "MACCSFP104",
  "MACCSFP105",
  "MACCSFP106",
  "MACCSFP107",
  "MACCSFP108",
  "MACCSFP109",
  "MACCSFP110",
  "MACCSFP111",
  "MACCSFP112",
  "MACCSFP113",
  "MACCSFP114",
  "MACCSFP115",
  "MACCSFP116",
  "MACCSFP117",
  "MACCSFP118",
  "MACCSFP119",
  "MACCSFP120",
  "MACCSFP121",
  "MACCSFP122",
  "MACCSFP123",
  "MACCSFP124",
  "MACCSFP125",
  "MACCSFP126",
  "MACCSFP127",
  "MACCSFP128",
  "MACCSFP129",
  "MACCSFP130",
  "MACCSFP131",
  "MACCSFP132",
  "MACCSFP133",
  "MACCSFP134",
  "MACCSFP135",
  "MACCSFP136",
  "MACCSFP137",
  "MACCSFP138",
  "MACCSFP139",
  "MACCSFP140",
  "MACCSFP141",
  "MACCSFP142",
  "MACCSFP143",
  "MACCSFP144",
  "MACCSFP145",
  "MACCSFP146",
  "MACCSFP147",
  "MACCSFP148",
  "MACCSFP149",
  "MACCSFP150",
  "MACCSFP151",
  "MACCSFP152",
  "MACCSFP153",
  "MACCSFP154",
  "MACCSFP155",
  "MACCSFP156",
  "MACCSFP157",
  "MACCSFP158",
  "MACCSFP159",
  "MACCSFP160",
  "MACCSFP161",
  "MACCSFP162",
  "MACCSFP163",
  "MACCSFP164",
  "MACCSFP165",
  "MACCSFP166"
)

# Fungsi untuk generate dataframe
do_generate_df <- function(arr_files) {
  result <- matrix(nrow = length(arr_files), ncol = 166)
  for(i in seq_along(arr_files)) {
    f <- read.csv(paste(folder_name, arr_files[i], sep = "/"))
    for(j in 2:167) {
      result[i, j-1] = f[1, j]
    }
  }
  colnames(result) <- col_label
  return(data.frame(result))
}
res_mtx = do_generate_df(csv_files)

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
# res_mtx = do_generate_df(fasta_files)

# Analisis cluster dengan complete linkage
res_cut_comp = do_clustering(res_mtx, "complete", "euclidean", 3)
res_ct_comp = contingency_table(res_cut_comp, res_mtx, fasta_files[1:15])
res_comp = purity_value(res_ct_comp, res_mtx)
print(res_comp)

# Analisis cluster dengan centroid linkage
res_cut_centr = do_clustering(res_mtx, "centroid", "euclidean", 3)
res_ct_centr = contingency_table(res_cut_centr, res_mtx, fasta_files[1:15])
res_centr = purity_value(res_ct_centr, res_mtx)
print(res_centr)