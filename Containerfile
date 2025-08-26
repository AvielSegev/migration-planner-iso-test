# Stage 1: Download and verify ISO
FROM --platform=linux/amd64 registry.access.redhat.com/ubi9/ubi AS builder

# Download the ISO
RUN curl -L -o /rhcos.iso \
    https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/latest/rhcos-4.19.0-x86_64-live-iso.x86_64.iso

# Verify checksum
RUN echo "6a9cf9df708e014a2b44f372ab870f873cf2db5685f9ef4518f52caa36160c36  /rhcos.iso" | sha256sum -c -

# Final stage: minimal image with only the ISO
FROM scratch
COPY --from=builder /rhcos.iso /

