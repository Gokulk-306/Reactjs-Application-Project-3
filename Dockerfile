FROM public.ecr.aws/nginx/nginx:alpine

COPY build/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
