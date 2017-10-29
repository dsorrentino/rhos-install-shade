import shade
import os
 
os.environ['REQUESTS_CA_BUNDLE'] = '/home/stack/undercloud.shade_test.pem'
 
# Initialize and turn on debug logging
shade.simple_logging(debug=True)
 
# Initialize cloud
# Cloud configs are read with os-client-config
cloud = shade.openstack_cloud(cloud='undercloud')


image = cloud.get_image(name_or_id='overcloud-full')
print(image)
 
