package com.Twitter;

 
public class Sample {
  public static void main(String[] args) {
	 int k = 15;
	  System.out.println(nextPrime(89));
	  System.out.println(mirror(678));
  }
  
  public static boolean isPrime(int num){
	 int flag = 0;
	  for(int i = 2; i < Math.sqrt(num); i++){
		  if(num % i == 0){
			  flag = 1;
			  break;
		  }
	  }
	  return !(flag == 1);
  }
  public static int nthPrime(int num){
	 int flag = 0,count = 1;
	 if(num == 1){
		 return 1;
	 }
	 for(int i = 2; true ; i++){
		  for(int j = 2; j <= Math.sqrt(i); j++){
			  if(i % j == 0){
				  flag = 1;
				  break;
			  }
		  }
		  if(flag == 0){
			  count++;
		  }
		  if(count == num){
			  return i;
		  }
		  flag = 0;
	  }
  }
  public static int nextPrime(int num){
	  int flag = 0,i = num + 1;
		 if(num == 1){
			 return 3;
		 }
		 for( i = num + 1; true ; i++){
			  for(int j = 2; j <= Math.sqrt(i); j++){
				  if(i % j == 0){
					  flag = 1;
					  break;
				  }
			  }
			  if(flag == 0){
				  break;
			  }
			  
			  flag = 0;
		  }
		 return i;	 
  }
  
  public static int mirror(int num){
	  int result = 0, flag = 0;
	  while(num != 0){
		  flag = num % 10;
		  num = num / 10;
		  result = result * 10 + flag;
	  }
	  return result;
  }
  
}
