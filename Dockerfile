# Use a lightweight Node.js image
FROM node:20-alpine

# Set working directory inside the container
WORKDIR /app

# Install Newman and HTML reporter globally
RUN npm install -g newman newman-reporter-htmlextra

# Copy Postman collections and environments into the container
COPY policycenter-tests ./policycenter-tests

# Create directory for test reports
RUN mkdir reports

# Default command: run PolicyCenter Postman tests
CMD newman run policycenter-tests/PolicyCenter_API_Tests.postman_collection.json \
    --environment policycenter-tests/PolicyCenter-Test.postman_environment.json \
    --reporters cli,htmlextra \
    --reporter-htmlextra-export reports/policycenter-report.html
