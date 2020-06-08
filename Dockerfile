#build phase
FROM node:alpine as builder

#changing the working directory of container to put all our code and config files here
WORKDIR '/app'

#copy only package.json file as it is only required by npm to run.
COPY package.json .

RUN npm install

#copy all files from local dir to container dir
COPY . .

#Create build
RUN npm run build

#Run phase
#base image for 2nd image 
FROM nginx

#copy code files from local to container directory
COPY --from=builder /app/build /usr/share/nginx/html