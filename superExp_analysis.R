library(dplyr); library(ggplot2)
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)



wp <- read.csv("WorldPop.csv")


wp %>% 
  ggplot(aes(x=Year,y=Pop)) + 
  geom_point()

min(wp$Year)
min(wp$Pop)

wp <- wp[-c(1:10),]
hum_dat <- list(N = length(wp$Pop),pop=wp$Pop/min(wp$Pop), yr = (wp$Year/1000))


mod1 <- stan(file = "human_superexp.stan", data = hum_dat, 
             chains = 6, iter = 6000)


print(mod1,digits=4)

post_a <- extract(mod1,pars = "alpha")[[1]]
post_b <- extract(mod1, pars = "beta")[[1]]


gro_fun <- function(x,alpha = alpha, beta = beta){
  return(((beta/(beta-x))^alpha))
}

samps <- sample(seq(1,length(post_a),1),500)


gro_plot <- ggplot(data = data.frame(x=c(0,1.2019)),aes(x=x)) +
  stat_function(fun = gro_fun, args = list(alpha = post_a[samps[1]],beta=post_b[samps[1]])) + 
  geom_point(data=data.frame(x=hum_dat[["yr"]],y=hum_dat[["pop"]]),aes(x=x,y=y))


for(i in 2:length(samps)){
  gro_plot <- gro_plot + 
    stat_function(fun = gro_fun, args = list(alpha = post_a[samps[i]],beta=post_b[samps[i]])) 
}









  


