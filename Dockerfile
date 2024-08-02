                                         
# Start with a minimal base image
FROM golang:1.22-alpine AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the go.mod and go.sum files to the working directory
COPY go.mod .

# Download all the dependencies
RUN go mod download

# Copy the source code to the working directory
COPY . .

# Build the application with optimizations
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main .

#######################################################
# Reduce the image size using multi-stage builds
# We will use a distroless image to run the application
FROM gcr.io/distroless/static-debian11

# Set the working directory inside the container
WORKDIR /app

# Copy the binary from the previous stage
COPY --from=base /app/main .

COPY --from=base /app/static ./static

# Expose the port on which the application will run
EXPOSE 8080

# Command to run the application
CMD ["./main"]
