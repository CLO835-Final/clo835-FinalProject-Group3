# clo835-final-project



<ul>
<li>1.	Application functionality is verified locally using docker image </li>
<li>2.	Application image is created automatically and pushed to Amazon ECR using GitHub Actions. </li>
<li>3.	Application is deployed into empty namespace “final” in Amazon EKS.</li>
<li>4.	Application is loading the background image from a private Amazon S3</li>
<li>5.	Data is persisted when the pod is deleted and re-created by the replicaset, Amazon EBS volume and K8s PV (PersistentVolume) are created dynamically when application pod is created</li>
<li>6.	Internet users can access the application</li>
<li>7.	Change the background image URL in the ConfigMap. Make sure a new image is visible in the browser.</li>
<li>8.	Bonus: demonstrate the auto-scaling functionality as a response to application load</li>






 # Author
Seneca Collage CAA Studensts - GROUP 3
<li>Arun Bains </li>
<li>Sneha Pillay </li>
<li>Sneha Mudavath </li>
<li>Roshan Fathima Sahul Hameed </li>
 
# Acknowledgement
 
<b>Prof. Irina Geiman for her kind guidance and timely help  &#128512;</b>







