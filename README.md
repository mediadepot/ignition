# MediaDepot Ignition

# Features
- Consistent UserID/GroupID across all containers so that permissions are always correct
- A DNS service that resolves containers with a nice hostname `*.depot.lan` from other computers on your home network, and for container to container communication
- A JBOD disk management system with minimal configuration, and fully transparent recovery/failure. MergerFS acts like a simple file proxy, and removed disks can be read on other computers with no additional tooling
- Ensure that virtual/JBOD disk is correctly mounted before allowing dependent programs/containers to start up.
- A lightweight status dashboard for checking system metrics
- A lightweight docker management system (Portainer) with customized templates for popular media-center applications
- Samba (SMB) shares automatically served from JBOD disk.
- Hard Disk montoring that uses S.M.A.R.T disk status to notify you if disks become unhealthy.
- NVIDIA driver installation (optional)
- MOTD dropins.

# Usage

1. Download bootable CoreOS image from https://coreos.com/os/docs/latest/booting-with-iso.html
2. Create bootable USB/CD with contents of CoreOS image
3. Start server and boot from CoreOS USB/CD.
4. Determine the OS installation disk
    ```bash
    sudo fdisk -l

    # note, the boot disk will probably be /dev/loop0
    ```
5. Copy the ignition remote config bootstrap file to the file system
    ```bash
    curl -O https://mediadepot.github.io/ignition/ignition-remote.json
    ```
6. Begin CoreOS installation on specified disk, **NOTE: specified disk will be reformatted**
    ```bash
    sudo coreos-install -d /dev/sda -C stable -i ignition-remote.json
    ```

7. On installation completion, remove bootable USB/CD
8. Restart server
9. Wait for CoreOS to start and `cloud-init` process to complete.
10. Go to `http://admin.depot.lan` to see Portainer dashboard and begin setup.



# Ignition Customizations for other users:
- `passwd.users.*.sshAuthorizedKeys.*`
- Have atleast 1 data drive (> 1TB) formatted with ext4
    - if your data disk isn't formatted yet, you can do so during installation, using `cfdisk` tool, or using "disk" attribute in
- `storage.filesystem.*`


#prerequsites:
- node has a static IP, using DHCP or route reservation
-


# References

## CT Transpiler
- https://coreos.com/os/docs/latest/overview-of-ct.html
- https://github.com/coreos/container-linux-config-transpiler/blob/master/doc/configuration.md

## CoreOS configuration
- https://coreos.com/os/docs/latest/booting-with-iso.html
- https://davranetworks.atlassian.net/wiki/spaces/MAN/pages/80936975/Bare+metal+install+of+CoreOS
- https://coreos.com/os/docs/latest/installing-to-disk.html
- https://gist.github.com/phumpal/d0007d314a12ee9c015e
- https://coreos.com/ignition/docs/latest/
- https://coreos.com/ignition/docs/latest/examples.html
- https://coreos.com/validate/
- https://github.com/coreos/ignition/blob/master/doc/configuration-v2_2.md
- `journalctl --identifier=ignition`
-

# SystemD
- https://container-solutions.com/running-docker-containers-with-systemd/
- https://developer.atlassian.com/blog/2015/03/docker-systemd-socket-activation/
- https://karlstoney.com/2017/03/03/docker-containers-as-systemd-services/
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/managing_containers/using_systemd_with_containers
- https://forums.docker.com/t/running-docker-containers-with-systemd-question/52681
- https://forums.docker.com/t/any-simple-and-safe-way-to-start-services-on-centos7-systemd/5695/11
- https://fardog.io/blog/2017/12/30/running-docker-containers-with-systemd/
- https://blog.marcnuri.com/docker-container-as-linux-system-service/
- https://unix.stackexchange.com/questions/441894/wait-to-start-transmission-daemon-until-after-usb-drive-has-mounted
- `systemctl list-units --all`
- https://fedoraproject.org/wiki/Packaging:Systemd#EnvironmentFiles_and_support_for_.2Fetc.2Fsysconfig_files

## MergerFS
- https://github.com/mitre/fusera/wiki/FUSE-and-Docker
- https://serverfault.com/questions/632075/convert-an-fstab-entry-to-a-systemd-mount-unit-on-coreos
- https://hynek.me/articles/docker-signals/
- https://blog.packagecloud.io/eng/2015/10/13/inspect-extract-contents-rpm-packages/
- https://github.com/coreos/bugs/issues/641
- https://github.com/coreos/bugs/issues/358
- http://webcache.googleusercontent.com/search?q=cache:NVzT88tLQD0J:www.ulabs.uservers.net/howtos/glusterfs-coreos.php+&cd=6&hl=en&ct=clnk&gl=us
- https://www.mikenowak.org/working-around-read-file-systems-coreos-overlay/


```
docker run -it -v `pwd`:/mounted centos /bin/bash
curl -O -L https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs-2.25.1-1.el7.x86_64.rpm
rpm2cpio mergerfs-2.25.1-1.el7.x86_64.rpm | cpio -idmv
cp -r bin/ /mounted/files/
```

- `mount -o "lowerdir=/usr/sbin,upperdir=/opt/sbin,workdir=/opt/sbin.workdir" -t overlay overlay /usr/sbin`

## Samba


## Rancher Config
- https://github.com/jmreicha/awesome-rancher
- https://rancher.com/docs/rancher/v2.x/en/upgrades/rollbacks/single-node-rollbacks/
- https://rancher.com/docs/rancher/v2.x/en/installation/single-node/
- https://rancher.com/docs/rancher/v2.x/en/backups/backups/single-node-backups/
- https://gist.github.com/superseb/c363247c879e96c982495daea1125276
- https://github.com/rancher/rancher/issues/16225
- https://github.com/rancher/rancher/issues/15477
- https://github.com/rancher/rancher/issues/13271
- https://github.com/rancher/cli


## Portainer
- https://portainer.readthedocs.io/en/stable/configuration.html
- https://app.swaggerhub.com/apis/deviantony/Portainer/1.19.2/#/templates/TemplateList
- https://tools.linuxserver.io/portainer.json
- https://blog.linuxserver.io/2017/11/28/how-to-setup-a-reverse-proxy-with-letsencrypt-ssl-for-all-your-docker-apps/
- https://blog.linuxserver.io/2018/02/03/using-traefik-as-a-reverse-proxy-with-docker/


## Notifications
- https://github.com/netdata/netdata/wiki/pushover-notifications
- https://www.reddit.com/r/homeautomation/comments/76eqmd/notification_options_slack_vs_pushover_vs/
- https://serverfault.com/questions/694818/get-notification-when-systemd-monitored-service-enters-failed-state


## Smartmontools
- https://www.maketecheasier.com/monitor-hard-disk-health-linux/
- https://www.reddit.com/r/linux/comments/5vemxu/otakutocrazydiskinfo_crazydiskinfo_an_interactive/
- https://www.reddit.com/r/DataHoarder/comments/7sx623/disk_health_check_programs_for_linuxmac/
- LIBATASMART
