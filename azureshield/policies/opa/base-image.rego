# OPA policy for base image restriction
package kubernetes.admission

# Allow only distroless or UBI 8/9 approved images
deny[msg] {
    input.request.kind.kind == "Pod"
    image := input.request.object.spec.containers[_].image
    not approved_base(image)
    msg := sprintf("Base image %v is not approved (must be distroless, UBI 8/9, or pinned)", [image])
}

approved_base(image) {
    # Mock base image checking
    contains(image, "distroless")
}
