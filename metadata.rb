name              "riemann-client"
maintainer        "Cloudbau GmbH"
maintainer_email  "fillme"
license           "fillme"
description       "installs riemann_client and riemann_health"
version           "1.0.0"

recipe "riemann-client", "Installs and configures the riemann-client and riemann-health"

depends "runit"
depends "rbenv"
