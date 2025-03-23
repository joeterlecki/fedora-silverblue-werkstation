sudo cp custom-oci-test.tar.gz /var/cache/
sudo rpm-ostree rebase ostree-unverified-image:oci-archive:/var/cache/custom-oci-test.tar.gz
