project_id=72348106-e324-493c-83df-56fccdab4a72
project_api_key=7b42x4ZR.k0iwsWclcCnLOeKUwNQY7k3oYPiduzBUuiV
access_token=

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

get_access_token

if ! get_access_token; then
    exit 1
fi

echo $access_token