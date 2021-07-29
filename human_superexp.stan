
data {
  int<lower=0> N;
  vector[N] pop;
  vector[N] yr;
}


parameters {
 real<lower=2.019,upper = 3> beta; 
 real<lower=0> alpha; 
 real<lower=0> sigma; 
}



model {
  
  alpha ~ exponential(1);
  
  for(i in 1:N)
  pop[i] ~ normal((beta*((beta-yr[i])^-1))^alpha, sigma);
}





