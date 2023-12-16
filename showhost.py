import logging
from mitmproxy.http import HTTPFlow

'''
mitmdump --set termlog_verbosity=warn --set flow_detail=0 -s showhost.py -p 8040
'''

class ShowHost:
    def responseheaders(self, flow: HTTPFlow) -> None:
        # stream response
        flow.response.stream = True

    def request(self, flow: HTTPFlow) -> None:
        logging.warn(f"{flow.request.method} {flow.request.host} {flow.request.path}")

addons = [ShowHost()]
