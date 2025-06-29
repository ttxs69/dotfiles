function proxy
    set -gx https_proxy http://127.0.0.1:7890
    set -gx http_proxy http://127.0.0.1:7890
    set -gx all_proxy socks5://127.0.0.1:7890
end

function unproxy
    set -ge https_proxy
    set -ge http_proxy
    set -ge all_proxy
end

