FROM tomcat:8.5-jre8-alpine
ADD ./target/digitalbank-2.1.0.local.war /usr/local/tomcat/webapps/digitalbank.war
CMD ["catalina.sh","run"]
