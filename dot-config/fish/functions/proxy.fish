function proxy
    set -x https_proxy http://127.0.0.1:7890
    set -x http_proxy http://127.0.0.1:7890
    set -x all_proxy socks5://127.0.0.1:7890
end

function unproxy
    set -e https_proxy
    set -e http_proxy
    set -e all_proxy
end

