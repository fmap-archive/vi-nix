{ pkgs, base, ... }: base.tor.override {
  # "We were built to run on a 64-bit CPU, with OpenSSL 1.0.1 or later, but with
  # a version of OpenSSL that apparently lacks accelerated support for the NIST
  # P-224 and P-256 groups. Building openssl with such support (using the
  # enable-ec_nistp_64_gcc_128 option when configuring it) would make ECDH much
  # faster."
  openssl = pkgs.lib.overrideDerivation pkgs.openssl (current: {
    configureFlags = current.configureFlags + " enable-ec_nistp_64_gcc_128";
  });
}
