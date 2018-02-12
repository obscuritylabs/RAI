# **GoPhish**  


The GoPhish container allows you to manage your phishing campaign.  It allows you to monitor emails delivered, 
opened, and clicked links. Gophish is a phishing framework that makes the simulation of real-world phishing attacks dead-simple. Per the creators of GoPhish [Located Here](https://www.gitbook.com/book/gophish/user-guide/details); "The idea behind gophish is simple – make industry-grade phishing training available to everyone."


## **Build Docker image**

```
sudo docker build -t repo/gophish:1.0 .
```


## **Run a Container**

```
docker run repo/https:1.0
```
## **Use GoPhish**  

After Gophish starts up, you can open a browser and navigate to **https://127.0.0.1:3333** to reach the login page.

The default credentials are:
Username: **admin**
Password: **gophish**
