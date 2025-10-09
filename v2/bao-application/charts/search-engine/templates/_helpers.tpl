{{/*
Expand the name of the chart.
*/}}
{{- define "search-engine.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "search-engine.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
apiVersion: v1
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "search-engine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "search-engine.labels" -}}
helm.sh/chart: {{ include "search-engine.chart" . }}
{{ include "search-engine.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "search-engine.selectorLabels" -}}
app.kubernetes.io/name: {{ include "search-engine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
kind: Secret
metadata:
  name: {{ include "search-engine.fullname" . }}-secret
  namespace: {{ .Values.namespace }}
  labels:
    {{- include "search-engine.labels" . | nindent 4 }}
type: Opaque
data:
  MEILI_MASTER_KEY: {{ .Values.meilisearch.masterKey | b64enc | quote }}

