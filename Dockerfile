# ---------- BUILD STAGE ----------
FROM golang:1.25.1-alpine AS builder

WORKDIR /app

# Install git
RUN apk add --no-cache git

# Copy dependency files first
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Copy environment file
COPY .env .env

# Build application
RUN go build -o muchtodo ./cmd/api

# ---------- FINAL STAGE ----------
FROM alpine:latest

WORKDIR /app

# Install certificates
RUN apk add --no-cache ca-certificates

# Create non-root user
RUN adduser -D appuser

# Copy built binary
COPY --from=builder /app/muchtodo .

# Copy environment file
COPY --from=builder /app/.env .env

# Use non-root user
USER appuser

# Expose application port
EXPOSE 8080

# Health check
HEALTHCHECK CMD wget --spider http://localhost:8080/health || exit 1

# Start application
CMD ["./muchtodo"]
