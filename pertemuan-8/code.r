# install.packages('devtools')
library('devtools')
# install_github('shwijaya/bmeasures', force=TRUE)
library('bmeasures')

# Import Data
df = read.csv("data.csv")

# Label
label <- df[3491]

# Distance Metric
dist_euclid <- dist(df, method = "euclidean")
dist_minkow <- dist(df, method = "minkowski")

# Clustering
clust_cmp_eucl = hclust(dist_euclid, method = "complete")
clust_cmp_mink = hclust(dist_minkow, method = "complete")
clust_avg_eucl = hclust(dist_euclid, method = "average")
clust_avg_mink = hclust(dist_minkow, method = "average")

plot(clust_cmp_eucl)
rect.hclust(clust_cmp_eucl, k = 4, border = "green")

plot(clust_cmp_eucl)
rect.hclust(clust_cmp_eucl, k = 3, border = "green")

plot(clust_cmp_mink)
rect.hclust(clust_cmp_mink, k = 4, border = "green")

plot(clust_cmp_mink)
rect.hclust(clust_cmp_mink, k = 3, border = "green")

plot(clust_avg_eucl)
rect.hclust(clust_avg_eucl, k = 4, border = "green")

plot(clust_avg_eucl)
rect.hclust(clust_avg_eucl, k = 3, border = "green")

plot(clust_avg_eucl)
rect.hclust(clust_avg_mink, k = 4, border = "green")

plot(clust_avg_eucl)
rect.hclust(clust_avg_mink, k = 3, border = "green")


# Cut Tree
cut_cmp_eucl4 = cutree(clust_cmp_eucl, k=4)
cut_cmp_eucl3 = cutree(clust_cmp_eucl, k=3)
cut_cmp_mink4 = cutree(clust_cmp_mink, k=4)
cut_cmp_mink3 = cutree(clust_cmp_mink, k=3)
cut_avg_eucl4 = cutree(clust_avg_eucl, k=4)
cut_avg_eucl3 = cutree(clust_avg_eucl, k=3)
cut_avg_mink4 = cutree(clust_avg_mink, k=4)
cut_avg_mink3 = cutree(clust_avg_mink, k=3)

# Purity
library("dplyr")
df_cmp_eucl4 <- mutate(df, cluster = cut_cmp_eucl4)
show(count(df_cmp_eucl4, cluster))
res_cmp_eucl4 <- table(df_cmp_eucl4$cluster, t(label))
show(res_cmp_eucl4)

df_cmp_eucl3 <- mutate(df, cluster = cut_cmp_eucl3)
show(count(df_cmp_eucl3, cluster))
res_cmp_eucl3 <- table(df_cmp_eucl3$cluster, t(label))
show(res_cmp_eucl3)

df_cmp_mink4 <- mutate(df, cluster = cut_cmp_mink4)
show(count(df_cmp_mink4, cluster))
res_cmp_mink4 <- table(df_cmp_mink4$cluster, t(label))
show(res_cmp_mink4)

df_cmp_mink3 <- mutate(df, cluster = cut_cmp_mink3)
show(count(df_cmp_mink3, cluster))
res_cmp_mink3 <- table(df_cmp_mink3$cluster, t(label))
show(res_cmp_mink3)

df_avg_eucl4 <- mutate(df, cluster = cut_avg_eucl4)
show(count(df_avg_eucl4, cluster))
res_avg_eucl4 <- table(df_avg_eucl4$cluster, t(label))
show(res_avg_eucl4)

df_avg_eucl3 <- mutate(df, cluster = cut_avg_eucl3)
show(count(df_avg_eucl3, cluster))
res_avg_eucl3 <- table(df_avg_eucl3$cluster, t(label))
show(res_avg_eucl3)

df_avg_mink4 <- mutate(df, cluster = cut_avg_mink4)
show(count(df_avg_mink4, cluster))
res_avg_mink4 <- table(df_avg_mink4$cluster, t(label))
show(res_avg_mink4)

df_avg_mink3 <- mutate(df, cluster = cut_avg_mink3)
show(count(df_avg_mink3, cluster))
res_avg_mink3 <- table(df_avg_mink3$cluster, t(label))
show(res_avg_mink3)

purity <- function(res_table) {
  mtx_sum = 0
  for(i in 1:nrow(res_table)) {
    mtx_sum = mtx_sum + max(res_table[i,])
  }
  return (mtx_sum)
}

pur_cmp_eucl4 = purity(res_cmp_eucl4)
pur_cmp_eucl3 = purity(res_cmp_eucl3)
pur_cmp_mink4 = purity(res_cmp_mink4)
pur_cmp_mink3 = purity(res_cmp_mink3)
pur_avg_eucl4 = purity(res_avg_eucl4)
pur_avg_eucl3 = purity(res_avg_eucl3)
pur_avg_mink4 = purity(res_avg_mink4)
pur_avg_mink3 = purity(res_avg_mink3)