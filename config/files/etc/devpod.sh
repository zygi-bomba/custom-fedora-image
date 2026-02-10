# /etc/profile.d/devpod.sh
# This automatically points DevPod to the rootless Podman socket
if [ -n "$XDG_RUNTIME_DIR" ]; then
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
fi
