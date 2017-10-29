rhos-install-shade Overview
===========================

The python shade libraries offer an easy way to interact with your Openstack Clouds
in your own Python code or utilizing the Openstack Ansible modules.  Today, there
are some incompatibilities between the Shade installation and the Triple-O install
where they don't work cleanly together.  To work around this, we leverage the
python-virtualenv package, create a Virtual Environment that can leverage the
site-location Python Modules and install Shade there.  This appears to be a viable
workaround until the dependancies and interactions between the two can be worked
out.

Setup and Configuration
-----------------------

Clone repository to the Director (Undercloud) node and execute the playbook:

ansible-playbook ./install_shade.yaml

Usage Instructions
------------------

Once shade is installed in a Virtual Environment, you need to source the 'activate'
script to enable Shade in your running environment whenever you want to use it.

To do this, execute:

source ~/shade/bin/activate

You will notice the prompt change indicating you are in the Virtual Environment.  
When you're done, simply run the following command to exit the Virtual Environment:

deactivate

_ANSIBLE NOTE:_

To utilize the Ansible Openstack Modules, you will need to do two things:

- For your Director node, you need to add the following parameter to the inventory file:

  ansible_python_interpeter=python

  The reason for this is because by default, Ansible will explicitly point to the Python
  that is installed on the system and not use the Python in the Virtual Environment.

- In your playbooks that you are using the Ansible Openstack Modules, you need to explictly
  pre-pend the Virtual Environment path by adding a playbook level setting:

    environment:
      PATH: '/home/stack/shade/bin:{{ ansible_env.PATH }}'

For examples of these changes, see the './tests' sub-directory.

Testing installation
--------------------

In the './tests/' sub-directory execute the script 'run_tests.sh' and this will verify
that shade is working from a Python as well as an Ansible perspective
