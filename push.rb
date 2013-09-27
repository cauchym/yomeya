require 'apns'

APNS.host = 'gateway.sandbox.push.apple.com'
APNS.pem = '/Users/kengo/yomeya/server_certificates_sandbox_2.pem'
APNS.pass = ''
APNS.port = 2195

token = '727e9862a15c665124bf095ee0e9e3cde2e8c7361317dd86da1366a626ca6b9f'
#APNS.send_notification(token,'HELLO')
APNS.send_notification(token, :alert => 'みーつけた☆', :badge => 9, :sound => 'default')

