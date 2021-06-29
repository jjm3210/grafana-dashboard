local grafana = import 'grafonnet/grafana.libsonnet';

local cluster = import 'cluster.libsonnet';
local cpu = import 'cpu.libsonnet';
local http = import 'http.libsonnet';
local memory_misc = import 'memory_misc.libsonnet';
local net = import 'net.libsonnet';
local operations = import 'operations.libsonnet';
local slab = import 'slab.libsonnet';
local utils = import 'utils.libsonnet';
local row = grafana.row;
local dashboard = grafana.dashboard;


local datasource = '${DS_PROMETHEUS}';
local rate_time_range = '$rate_time_range';
local job = '[[job]]';

grafana.dashboard.new(
  title='Tarantool dashboard',
  description='Dashboard for Tarantool application and database server monitoring, based on grafonnet library.',
  editable=true,
  schemaVersion=21,
  time_from='now-3h',
  time_to='now',
  refresh='30s',
  tags=['tarantool'],
)
.addRequired(
  type='grafana',
  id='grafana',
  name='Grafana',
  version='6.6.0'
)
.addRequired(
  type='panel',
  id='graph',
  name='Graph',
  version=''
)
.addRequired(
  type='panel',
  id='text',
  name='Text',
  version=''
)
.addRequired(
  type='panel',
  id='stat',
  name='Stat',
  version='',
)
.addRequired(
  type='panel',
  id='table',
  name='Table',
  version='',
)
.addRequired(
  type='datasource',
  id='prometheus',
  name='Prometheus',
  version='1.0.0'
)
.addInput(
  name='DS_PROMETHEUS',
  label='Prometheus',
  type='datasource',
  pluginId='prometheus',
  pluginName='Prometheus',
  description='Prometheus Tarantool metrics bank'
)
.addInput(
  name='PROMETHEUS_JOB',
  label='Job',
  type='constant',
  pluginId=null,
  pluginName=null,
  description='Prometheus Tarantool metrics job'
)
.addInput(
  name='PROMETHEUS_RATE_TIME_RANGE',
  label='Rate time range',
  type='constant',
  value='2m',
  description='Time range for computing rps graphs with rate(). At the very minimum it should be two times the scrape interval.'
)
.addTemplate(
  grafana.template.custom(
    name='job',
    query='${PROMETHEUS_JOB}',
    current='${PROMETHEUS_JOB}',
    hide='variable',
    label='Prometheus job',
  ),
)
.addTemplate(
  grafana.template.custom(
    name='rate_time_range',
    query='${PROMETHEUS_RATE_TIME_RANGE}',
    current='${PROMETHEUS_RATE_TIME_RANGE}',
    hide='variable',
    label='rate() time range',
  ),
).addPanels(utils.generate_grid([
  cluster.row { gridPos: { w: 24, h: 1 } },

  cluster.health_overview_table(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 12, h: 8, x: 0, y: 1 } },

  cluster.health_overview_stat(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 3, x: 12, y: 1 } },

  cluster.memory_used_stat(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 4, h: 5, x: 12, y: 4 } },

  cluster.memory_reserved_stat(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 4, h: 5, x: 16, y: 4 } },

  cluster.space_ops_stat(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 4, h: 4, x: 20, y: 1 } },

  cluster.http_rps_stat(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 4, h: 4, x: 20, y: 5 } },

  cluster.cartridge_warning_issues(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 12, h: 6 } },

  cluster.cartridge_critical_issues(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 12, h: 6 } },

  cluster.replication_lag(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 24, h: 8 } },

  http.row { gridPos: { w: 24, h: 1 } },

  http.rps_success(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  http.rps_error_4xx(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  http.rps_error_5xx(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  http.latency_success(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  http.latency_error_4xx(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  http.latency_error_5xx(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  net.row { gridPos: { w: 24, h: 1 } },

  net.bytes_received_per_second(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 12, h: 8 } },

  net.bytes_sent_per_second(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 12, h: 8 } },

  net.net_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  net.net_pending(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  net.current_connections(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.row { gridPos: { w: 24, h: 1 } },

  slab.monitor_info() { gridPos: { w: 24, h: 3 } },

  slab.quota_used_ratio(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.arena_used_ratio(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.items_used_ratio(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.quota_used(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.arena_used(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.items_used(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.quota_size(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.arena_size(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  slab.items_size(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 8, h: 8 } },

  cpu.row { gridPos: { w: 24, h: 1 } },

  cpu.getrusage_cpu_user_time(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 12, h: 8 } },

  cpu.getrusage_cpu_system_time(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 12, h: 8 } },

  memory_misc.row { gridPos: { w: 24, h: 1 } },

  memory_misc.lua_memory(
    datasource=datasource,
    job=job,
  ) { gridPos: { w: 24, h: 8 } },

  operations.row { gridPos: { w: 24, h: 1 } },

  operations.space_select_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.space_insert_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.space_replace_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.space_upsert_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.space_update_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.space_delete_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.call_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.eval_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.error_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.auth_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.SQL_prepare_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },

  operations.SQL_execute_rps(
    datasource=datasource,
    job=job,
    rate_time_range=rate_time_range,
  ) { gridPos: { w: 8, h: 8 } },
]))
