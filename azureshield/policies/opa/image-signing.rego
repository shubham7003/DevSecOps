# OPA policy for image signing validation
package kubernetes.admission

# Deny any pod using an unsigned container image
deny[msg] {
    input.request.kind.kind == "Pod"
    image := input.request.object.spec.containers[_].image
    not is_signed(image)
    msg := sprintf("Image %v is not signed by Cosign or not from trusted ACR", [image])
}

is_signed(image) {
    # Mock signature verification logic
    # In reality, this communicates with a signature verification provider
    contains(image, "myPremiumACR")
}
