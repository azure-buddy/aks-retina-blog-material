# Getting the first available node
if [[ -z $1 ]]; then 
  target=`kubectl get nodes -o 'jsonpath={.items[0].metadata.name}'`
else
  target=$1
fi

cat <<EOF | kubectl create -f -
apiVersion: retina.sh/v1alpha1
kind: Capture
metadata:
  name: my-first-capture
spec:
  captureConfiguration:
    captureOption:
      duration: 30s
    captureTarget:
      nodeSelector:
        matchLabels:
          kubernetes.io/hostname: ${target}
  outputConfiguration:
    hostPath: "/tmp/retina"
    blobUpload: blob-sas-url
EOF