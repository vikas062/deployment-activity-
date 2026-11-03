# Use official lightweight Nginx image
FROM nginx:alpine

# Copy the HTML file to Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
