# ippsample-docker

[ippsample](https://github.com/istopwg/ippsample) in a Docker container.

## Usage

The ippsample commands are in the container's `$PATH`, so you can run them like this:
```bash
docker run --rm -p 8000:8000 ghcr.io/benpueschel/ippsample-docker:main ippserver -p 8000 "My IPP Sample Printer"
```

To configure DNS-SD (using Avahi), you need to pass environment variables to the container as explained in the [flungo/avahi Docker image](https://github.com/flungo-docker/avahi?tab=readme-ov-file#environment-variables).

For example:
```bash
docker run --rm -p 8000:8000 \
    -e SERVER_HOST_NAME="hostname" \
    -e PUBLISH_PUBLISH_ADDRESSES="yes" \
    ghcr.io/benpueschel/ippsample-docker:main \
    ippserver -p 8000 "My IPP Sample Printer"
```
