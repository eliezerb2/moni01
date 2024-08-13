# Define Prometheus URL and target job name
$prometheusUrl = "http://localhost:9090"
$targetJobName = "tls-grade-exporter-metrics"

# Function to check the status of a target in Prometheus
function Test-PrometheusTargetStatus {
    param (
        [string]$prometheusUrl,
        [string]$targetJobName
    )
    
    try {
        # Query the Prometheus API for targets
        $apiUrl = "$prometheusUrl/api/v1/targets"
        $response = Invoke-RestMethod -Uri $apiUrl -Method Get
        
        # Filter targets based on job name
        $targets = $response.data.activeTargets | Where-Object { $_.labels.job -eq $targetJobName }

        if ($targets.Count -eq 0) {
            Write-Output "No targets found for job '$targetJobName'."
        } else {
            # Check the status of each target
            $targets | ForEach-Object {
                $status = $_.health
                Write-Output "Target '$($targetJobName)' is '$status'. Last scrape status: $($status)."
            }
        }
    } catch {
        # Handle errors if the request fails
        Write-Output "Failed to reach Prometheus API. Error: $_"
    }
}

# Run the function to check Prometheus target status
Test-PrometheusTargetStatus -prometheusUrl $prometheusUrl -targetJobName $targetJobName
