resource "aws_amplify_app" "amplify-react-graphql" {
  name       = "amplify-react-graphql"
  repository = "https://github.com/tsj7ww/health-webapp-frontend"
  # GitHub personal access token
  access_token = "..."

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 1
    frontend:
        phases:
            preBuild:
                commands:
                    - npm ci
            build:
                commands:
                    - npm run build
        artifacts:
            baseDirectory: build
            files:
                - '**/*'
        cache:
            paths:
                - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    ENV = "test"
  }
}