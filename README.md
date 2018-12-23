CSV Validator
================

* This is a service for validating CSV files that can be easily deployed through docker.
* You program the custom rules through the web UI.
* Rules can be combined in various ways to create a **rule-set**.
* When you are happy with your set of rules, call one of the validator's API endpoints to have it validate one of your CSV files.
  * The request will contain:
    * the **rule-set ID** to validate against
    * a url to where the CSV can be downloaded by the validator.
    * a url for the validator to **POST** a response to (webhook) stating if validation succeeded or failed and for what reason.


## Deployment
* Rename the `.env.tmpl` file to `.env` and fill it in.
* Build the docker image with `bash docker/build.sh`
* Install [docker](https://blog.programster.org/ubuntu-18-04-install-docker) and [docker-compose](https://blog.programster.org/debian-8-install-docker-compose) if you haven't already.
* Run `docker-compose up`


## HTTPS / SSL
If you need SSL / HTTPS, then you have several options:
* Use [jwilder proxy](https://github.com/jwilder/nginx-proxy) container
    * [Programster tutorial](https://blog.programster.org/hosting-multiple-dockerized-websites-on-a-single-host)
* Use [Traefik](https://traefik.io/)
    * [Programster tutorial](https://blog.programster.org/using-traefik-with-docker-swarm-for-deploying-web-applications)
* If you are an AWS user, use an [elastic load balancer](https://stackoverflow.com/questions/26962066/aws-ssl-https-on-load-balancer) (ELB).
* [Manually deploy and configure a reverse proxy](http://blog.programster.org/debian-9-set-up-nginx-reverse-proxy).