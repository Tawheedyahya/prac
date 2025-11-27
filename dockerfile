# Use the official PHP image with Apache
FROM php:8.3-apache

# Remove the default HTML content from the web root
RUN rm -rf /var/www/html/*

# Set the working directory
WORKDIR /var/www/html/

# Copy your local project files into the container's web root
COPY . .

# Configure Apache to listen on port 8000
RUN echo "Listen 200" >> /etc/apache2/ports.conf

# Configure Apache virtual host to listen on port 8000

RUN echo "<VirtualHost *:200>\n\
    DocumentRoot /var/www/html\n\
    DirectoryIndex index.php index.html\n\
    <Directory /var/www/html/>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf


# Enable the rewrite module for Apache (optional, but useful for PHP apps)
RUN a2enmod rewrite

# Expose port 8000
EXPOSE 200

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
