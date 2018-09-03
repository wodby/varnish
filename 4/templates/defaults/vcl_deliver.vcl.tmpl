sub vcl_deliver {
    unset resp.http.X-VC-Req-Host;
    unset resp.http.X-VC-Req-URL;
    unset resp.http.X-VC-Req-URL-Base;
    unset resp.http.Via;

    # Remove ban-lurker friendly custom headers when delivering to client.
    unset resp.http.X-Url;
    unset resp.http.X-Host;
    unset resp.http.Cache-Tags;

    if (obj.hits > 0) {
        set resp.http.X-VC-Cache = "HIT";
    } else {
        set resp.http.X-VC-Cache = "MISS";
    }

    if (req.http.X-VC-Debug ~ "true" || resp.http.X-VC-Debug ~ "true") {
        set resp.http.X-VC-Hash = req.http.hash;
        if (req.http.X-VC-DebugMessage) {
            set resp.http.X-VC-DebugMessage = req.http.X-VC-DebugMessage;
        }
    } else {
        unset resp.http.X-VC-Enabled;
        unset resp.http.X-VC-Debug;
        unset resp.http.X-VC-DebugMessage;
        unset resp.http.X-VC-Cacheable;
        unset resp.http.X-VC-Purge-Key-Auth;
        unset resp.http.X-VC-TTL;
    }
}
