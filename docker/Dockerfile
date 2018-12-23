# Due to layout of this project, the dockerfile will be moved up two directories and run during
# the build. Thus when performing any ADD commands, remember that this is "where you are"

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get dist-upgrade -y

# Install the relevant packages
RUN apt-get install vim apache2 curl libapache2-mod-php7.2 \
    php7.2-cli php7.2-mysql php7.2-curl php7.2-xml php7.2-simplexml -y

# Enable the php mod we just installed
RUN a2enmod php7.2
RUN a2enmod rewrite


# expose port 80 and 443 (ssl) for the web requests
EXPOSE 80
EXPOSE 443

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# It appears that the new apache requires these env vars as well
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid


###### Update the php INI settings #########

# Uncomment any of these if you need them.

# Increase php's max allowed memory size
#RUN sed -i 's;memory_limit = .*;memory_limit = -1;' /etc/php5/apache2/php.ini
#RUN sed -i 's;memory_limit = .*;memory_limit = -1;' /etc/php5/cli/php.ini

#RUN sed -i 's;display_errors = .*;display_errors = On;' /etc/php5/apache2/php.ini
#RUN sed -i 's;display_errors = .*;display_errors = On;' /etc/php5/cli/php.ini


# Set the max execution time
#RUN sed -i 's;max_execution_time = .*;max_execution_time = -1;' /etc/php5/apache2/php.ini
#RUN sed -i 's;max_execution_time = .*;max_execution_time = -1;' /etc/php5/cli/php.ini

# This is also needed for execution time
#RUN sed -i 's;max_input_time = .*;max_input_time = -1;' /etc/php5/apache2/php.ini


# Install the cron service to tie up the container's foreground process
RUN apt-get install cron -y

# Add the site's code to the container.
# We could mount it with volume, but by having it in the container, deployment is easier.
ADD src /var/www/my-site/project

# Update our apache sites available with the config we created
ADD docker/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Add our startup script to the container so we can run it at startup.
ADD docker/startup.sh /root/startup.sh

# Configure apache to work with ssl.
# NOTE: the ssl certs will not exist in the container yet as they are injected through a volume
# from the environment
#RUN a2enmod ssl
#ADD app/docker/apache-ssl-config.conf /etc/apache2/sites-available/default-ssl.conf
#RUN a2ensite default-ssl


# Use the crontab file.
# The crontab file was already added when we added "project"
#RUN crontab /var/www/my-site/project/docker/crons.conf

# Set permissions
RUN chown root:www-data -R /var/www
RUN chmod 750 -R /var/www

# Execute the containers startup script which will start many processes/services
# The startup file was already added when we added "project"
CMD ["/bin/bash", "/root/startup.sh"]
