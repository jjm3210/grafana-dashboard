# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## Changed
- Make Prometheus rps graphs rate() time range configurable

## [0.2.1] - 2020-12-11
Grafana revisions: [Prometheus revision 2](https://grafana.com/api/dashboards/13054/revisions/2/download)

## Added
- Cluster overview panels for Prometheus

## [0.2.0] - 2020-09-23
Grafana revisions: [InfluxDB revision 3](https://grafana.com/api/dashboards/12567/revisions/3/download), [Prometheus revision 1](https://grafana.com/api/dashboards/13054/revisions/1/download)

## Added
- Dashboard for Prometheus

## Changed
- Update metrics version to 0.5.0
- Replace average latency collector with summary collector in example cluster
- Replace average latency panels with summary 99th percentile panels

## Fixed
- Example cluster now starts successfully
- Example cluster metrics no more breaks Prometheus metrics collect

## [0.1.1] - 2020-09-04
Grafana revisions: [InfluxDB revision 2](https://grafana.com/api/dashboards/12567/revisions/2/download)

### Added
- Publish dashboard on Grafana official and community built dashboards
- Generate HTTP and space operations traffic for example cluster with luatest

### Changed
- Update metrics version to 0.3.0 in experimental cluster
- Rework example Tarantool instance on "cartridge.roles.metrics"
- Rework example Tarantool docker to start multiple instances with luatest
- Make InfluxDB policy configurable
- Documentation improvements and fixes

## [0.1.0] - 2020-06-30
Grafana revisions: [InfluxDB revision 1](https://grafana.com/api/dashboards/12567/revisions/1/download)

### Added
- Ready for import InfluxDB dashboard: HTTP panels, memory panels, space operations panels
- Experimental docker cluster: Tarantool + Telegraf + InfluxDB + Grafana, Tarantool + Prometheus + Grafana
- Simple test on InfluxDB dashboard
- Build environment and documentation
