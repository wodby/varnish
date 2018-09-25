sub vcl_recv {
    {{ $exclude_urls := (getenv "VARNISH_DRUPAL_EXCLUDE_URLS" "^(/update\\.php|/([a-z]{2}/)?admin|/([a-z]{2}/)?admin/.*|/([a-z]{2}/)?system/files/.*|/([a-z]{2}/)?flag/.*|.*/ajax/.*|.*/ahah/.*)$") }}

    # Pass through any administrative or AJAX-related paths.
    if (req.url ~ "{{ $exclude_urls }}") {
        return (pass);
    }

    if (req.url ~ "(^/([a-z]{2}/)?batch)") {
        return (pipe);
    }

    # Remove all cookies that Drupal doesn't need to know about. We explicitly
    # list the ones that Drupal does need, the SESS and NO_CACHE. If, after
    # running this code we find that either of these two cookies remains, we
    # will pass as the page cannot be cached.
    if (req.http.Cookie) {
        {{ $preserved_cookies := (getenv "VARNISH_DRUPAL_PRESERVED_COOKIES" "SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE") }}

        # 1. Append a semi-colon to the front of the cookie string.
        # 2. Remove all spaces that appear after semi-colons.
        # 3. Match the cookies we want to keep, adding the space we removed
        #    previously back. (\1) is first matching group in the regsuball.
        # 4. Remove all other cookies, identifying them by the fact that they have
        #    no space after the preceding semi-colon.
        # 5. Remove all spaces and semi-colons from the beginning and end of the
        #    cookie string.
        set req.http.Cookie = ";" + req.http.Cookie;
        set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
        set req.http.Cookie = regsuball(req.http.Cookie, ";({{ $preserved_cookies }})=", "; \1=");
        set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
        set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

        if (req.http.Cookie == "") {
            # If there are no remaining cookies, remove the cookie header. If there
            # aren't any cookie headers, Varnish's default behavior will be to cache
            # the page.
            unset req.http.Cookie;
        }
        else {
            # If there is any cookies left (a session or NO_CACHE cookie), do not
            # cache the page. Pass it on to Apache directly.
            return (pass);
        }
    }
}
