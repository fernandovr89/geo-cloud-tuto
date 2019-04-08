# Geo-Cloud Workshop
Tutorial: How to run Madagascar FWI [1] on a Jupyter-Docker container [2].

## 1. Create a Google Compute Engine (GCE) instance.

First, we will grant access to the instance via Internet to use Jupyter notebooks. 

For that, we need to enter (or create) the [Google Cloud project](https://console.cloud.google.com/) and create a firewall rule:

1.1. Click to the Menu:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_gccmenu_hl.jpg" alt="fwrule01" width="300"/>

1.2. Go to **Networking** and open the **Firewall rules** option: 

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_gccfwrules_hl.jpg" alt="fwrule02" width="300"/>

1.3. Type the name of the firewall rule (e.g. *jupyter*):

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpyopt1_hl.jpg" alt="fwrule03" width="400"/>

1.4. Type the tag (you can use the same as the rule name; e.g. *jupyter*), type the Source IP range `0.0.0.0` and type the tcp port `8888`:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpyopt2_hl.jpg" alt="fwrule04" width="400"/>

1.5 Verify the *jupyter* tag is OK:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpy_fwok_clr.jpg" alt="fwrule05" width="800"/>


1.6. In the Project Menu, go to **Compute Engine** and choose the **VM instances** option:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_insopt_hl.jpg" alt="gceins01" width="300"/>

1.7. Type the name of your instance (e.g. gpu-team1). In **Machine type**, select **Customize** and add one GPU device:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_instcrt1_hl.jpg" alt="gceins02" width="400"/>

1.8. Change the default **Boot disk**, select  _Ubuntu 16.04 TLS_  and add more capacity to your disk (e.g. 50 GB):

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_instcrt2_hl.jpg" alt="gceins03" width="400"/>

1.9. Allow the access to HTTP traffic, open the **Management,security...** options, type your tag (_jupyter_) in **Networking**
and create your instance:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_intcrt3_hl.jpg" alt="gceins04" width="400"/>

1.10. Once your instance is created, you can access to it by opening a terminal in a browser window (SSH protocol):

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_instok_hl.jpg" alt="gceins05" width="800"/>


## 2. Install CUDA and verify Docker containers can access the GPU.

2.1. Access as root (you may use a simple password [e.g. *1234*]):  

`sudo passwd`  
`su `

As root:

2.2. Clone the geo-cloud installation files (i.e. CUDA, docker and nvidia-docker): 

`git clone https://github.com/fernandovr89/geo-cloud-install.git`


2.3. Install CUDA (Give execution access if needed `chmod +x ./geo-cloud-install/install_cuda.sh`): 

`sh ./geo-cloud-install/install_cuda.sh` 

2.4. Verify CUDA tools can access the GPU device:  

`nvidia-smi`

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_nvidia-docker_hl.jpg" alt="gceins09" width="800"/>

2.5. Install Docker and nvidia-docker (give execution access if needed `chmod +x ./geo-cloud-install/install_nvidia-docker.sh`): 

`sh ./geo-cloud-install/install_nvidia-docker.sh` 


2.5. Verify Docker containers can access the GPU device:

`docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi`

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_nvidia-smi_hl.jpg" alt="gceins10" width="800"/>


## 3. Run the gpufwi script using Jupyter.

3.1. Run the dockerized Jupyter notebook [3] using the following command:

```
docker run --runtime=nvidia -it -p 80:8888 \
   fernandovr89/cuda:jpytr_ahay /opt/conda/bin/jupyter notebook \
   --notebook-dir=/opt/notebooks --no-browser --allow-root \
   --ip=0.0.0.0 --port=8888
 ```
 Note: It will automatically download a (docker image)[https://hub.docker.com/r/fernandovr89/cuda] with Madagascar and CUDA installed.
 
 3.2.  Copy the _token_ (the number after `...?token=`):

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrtoken_hl.png" alt="gceins11" width="600"/>
 
 3.3. In the GCP window, open Jupyter by clicking the external http IP of your instance:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytraccess_hl.jpg" alt="gceins12" width="600"/>

3.4. Paste the _token_ and log in:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrpasswd_hl.jpg" alt="gceins13" width="400"/>

3.5. Create a new **Text File**:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrnewtext_hl.jpg" alt="gceins14" width="600"/>

3.6. Copy the **SConstruct** file from [this script](https://github.com/fernandovr89/geo-cloud-gpufwi/blob/master/SConstruct), name it and save it (this is a script with the instructions to run FWI on GPU devices using Madagascar [4]):

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrsavetext_hl.jpg" alt="gceins15" width="600"/>

3.7. Create a new **Python 2** Notebook:

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrnewpython_hl.jpg" alt="gceins16" width="600"/>

3.8. Copy the instruction _cells_ from [this notebook](https://github.com/fernandovr89/geo-cloud-gpufwi/blob/master/gpufwi.ipynb)

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_jpytrrunnote_hl.jpg" alt="gceins17" width="600"/>

**Great! After a few minutes you can obtain your first Geo-Cloud results**

## Extras

If you want to continue working on the Cloud. You can run the script of the Reverse Time Migration (RTM) GPU implementation [5] on Marmousi model. [scons script](http://www.ahay.org/RSF/book/xjtu/gpurtm/marmousi.html).

Note: You better create a new folder with a new __SConstruct__ file using the Jupyter notebook.

## IMPORTANT!

Don't forget to delete your instance. Otherwise, it will continue running and increasing the bill!

I.1. Select the instance and click on the delete button.

<img src="https://raw.githubusercontent.com/fernandovr89/geo-cloud-images/master/images/image_dltinst_hl.jpg" alt="gceins18" width="600"/>


## References:

[1] [Madagascar Webpage - Seismic processing software](http://www.ahay.org/wiki/Main_Page)

[2] Medium.com post of @allenday: [Jupyter + Tensorflow + Nvidia GPU + Docker + Google Compute Engine](https://medium.com/google-cloud/jupyter-tensorflow-nvidia-gpu-docker-google-compute-engine-4a146f085f17)

[3] Docker image of @fernandovr89: [Madagascar - Seismic processing software running on Ubuntu 16.04TLS ](https://hub.docker.com/r/fernandovr89/cuda)

[4] _A graphics processing unit implementation of time-domain full-waveform inversion_ by Pengliang Yang, Jinghuai Gao, and Baoli Wang: Geophysics, 80, F31-F39, (2015)
[scons script](http://www.reproducibility.org/RSF/book/xjtu/gpufwi/marmtest.html)

[5] _RTM using effective boundary saving: A staggered grid GPU implementation_ by Pengliang Yang, Jinghuai Gao, and Baoli Wang: Computers & Geosciences, 68, 64-72, (2014)
[scons script](http://www.ahay.org/RSF/book/xjtu/gpurtm/marmousi.html)
