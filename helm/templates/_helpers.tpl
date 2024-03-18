{{- define "chart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "chart.labels" }}
  app: {{ .Release.Name }}
  chart: {{ .Chart.Name }}
  namespace: {{ .Release.Namespace }}
  version: {{ .Chart.Version }}
{{- end -}}
