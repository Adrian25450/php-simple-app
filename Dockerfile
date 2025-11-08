# Imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Copiar todos los archivos del proyecto al directorio web del contenedor
COPY . /var/www/html/

# Dar permisos apropiados
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 para HTTP
EXPOSE 80

# Comando por defecto que arranca Apache
CMD ["apache2-foreground"]
