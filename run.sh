project_id=72348106-e324-493c-83df-56fccdab4a72
project_api_key=7b42x4ZR.k0iwsWclcCnLOeKUwNQY7k3oYPiduzBUuiV
workflow_id=a9cdb7f9-352b-465a-bfe2-99d8c4acf944
access_token=
job_id=
function get_access_token()
{
    output=$(curl -sX POST \
        "https://$project_id:$project_api_key@api.up42.com/oauth/token" \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -d 'grant_type=client_credentials')
    
    if [ -z "$output" ]; then
        echo "Unable to get access token"
        return 1
    fi
    
    access_token=$(echo $output | jq -r ".access_token")
    
    if [ -z "$access_token" ]; then
        echo "Unable to get access token from json"
        return 1
    fi
    
    return 0
}
function create_and_run_job()
{
    output=$(curl -sX POST \
        "https://api.up42.com/projects/$project_id/workflows/$workflow_id/jobs" \
        -H "Authorization: Bearer $access_token" \
        -H "Content-Type: application/json" \
        -d '{
                "sobloo-s2-l1c-aoiclipped:1": {
                    "ids": [
                        "S2A_MSIL1C_20190820T110621_N0208_R137_T30STF_20190820T132731"
                    ],
                    "bbox": [
                        -5.369294,
                        36.104358,
                        -5.33309,
                        36.165145
                    ],
                    "limit": 1,
                    "zoom_level": 14
                },
            "sharpening:1": {
                "strength": "medium"
            }
        }')
    
    if [ -z "$output" ]; then
        echo "Unable to create and run a job"
        return 1
    fi
    
    job_id=$(echo "$output" | jq -r ".data.id")
    
    if [ -z "$job_id" ]; then
        echo "Unable to get job id"
        return 1
    fi
    
    return 0
}
function check_job_state()
{
    output=$(curl -X GET \
        "https://api.up42.com/projects/$project_id/jobs/$job_id" \
        -H "Authorization: Bearer $access_token")
        
    if [ -z "$output" ]; then
        echo "Unable to job status"
        return 1
    fi
    
    job_status=$(echo "$output" | jq -r ".data.status")
    
    echo "The status of the job is: $job_status"
}
if ! get_access_token; then
    exit 1
fi
if ! create_and_run_job; then
    exit 1
fi
check_job_state
