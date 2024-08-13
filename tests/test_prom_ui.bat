@echo off
rem Open the Prometheus graph in the default web browser
start "" "http://127.0.0.1:9090/graph?g0.expr=http_server_requests_seconds_count&g0.tab=0&g0.display_mode=lines&g0.show_exemplars=1&g0.range_input=1m&g1.expr=http_server_requests_active_seconds_max&g1.tab=1&g1.display_mode=lines&g1.show_exemplars=0&g1.range_input=1h"
