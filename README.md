# Usage

1. Download bootable CoreOS image from https://coreos.com/os/docs/latest/booting-with-iso.html
    - Eventually will be replaced with custom Mediadepot customized iso.
2. Create bootable USB with contents of CoreOS image using __________
3. Add the following `ignition` configuration file to the USB.
    ```yaml
{
  "ignition": {
    "version": "2.2.0",
    "config": {
      "replace": {
        "source": "https://mediadepot.github.io/ignition/ignition.json"
      }
    }
  }
}
    ```
4. Start server and boot from CoreOS USB.
5. Determine the OS installation disk
    ```bash
    sudo fdisk -l

    # note, the boot disk will probably be /dev/loop0
    ```

6. Begin CoreOS installation on specified disk, **NOTE: specified disk will be reformatted**
    ```bash
    coreos-install -d /dev/sda -C stable -i ignition.json
    ```

7. On installation completion, remove bootable USB
8. Restart server
9. Wait for CoreOS to start and `cloud-init` process to complete.
10. Go to `http://depot:50000` to see Rancher v2 dashboard and begin setup.




# References

- https://coreos.com/os/docs/latest/booting-with-iso.html
- https://davranetworks.atlassian.net/wiki/spaces/MAN/pages/80936975/Bare+metal+install+of+CoreOS
- https://coreos.com/os/docs/latest/installing-to-disk.html
- https://gist.github.com/phumpal/d0007d314a12ee9c015e
- https://coreos.com/ignition/docs/latest/
- https://developer.atlassian.com/blog/2015/03/docker-systemd-socket-activation/
- https://coreos.com/ignition/docs/latest/examples.html
- https://coreos.com/validate/