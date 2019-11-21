#tagging it "builder"
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

CMD run npm build
#Don't need volumes because this won't change ^ because this 
#   is a production environment and we aren't changing our code

#RUN PHASE - using nginx
FROM nginx
#copy that build from one above and put in here (just important stuff). 
#  the /usr/share part is from website hub.docker.com under nginx "hosting a simple web..."
COPY --from=builder /app/build /usr/share/nginx/html 
#don't need a command to run it because it will automatically