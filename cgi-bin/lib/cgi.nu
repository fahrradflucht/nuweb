export def body [] {
    (cat -)
}

export def headers [] {
    let http_env_vars = ($env | transpose key value | where { |it|
        $it.key | str starts-with "HTTP_"
    })

    ($http_env_vars | reduce -f {} { |it, acc|
        let key = ($it.key | str replace "HTTP_" "" | str kebab-case)

        $acc | insert $key $it.value
    })
}

export def method [] {
    ($env | get "REQUEST_METHOD")
}

export def path [] {
    let request_uri = ($env | get "REQUEST_URI")

    $"http://example.com" + $request_uri | url parse | get path
}

export def query [] {
    let query = ($env | get "QUERY_STRING")

    $"http://example.com/?" + $query | url parse | get params
}

export def render_response [response] {
    print $"Status: ($response.status)"

    ($response.headers | transpose key value | each { |it|
        print $"($it.key): ($it.value)"
    })

    print $"\n($response.body)"
}
