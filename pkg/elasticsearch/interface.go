package elasticsearch

import (
	xov1alpha1 "github.com/90poe/elasticsearch-objects-operator/pkg/apis/xo/v1alpha1"
)

//ES is interface for ElasticSearch
type ES interface {
	//Index
	CreateUpdateIndex(index *xov1alpha1.ElasticSearchIndex) (string, error)
	DeleteIndex(indexName string) error
	//Template
	CreateUpdateTemplate(tmpl *xov1alpha1.ElasticSearchTemplate) (string, error)
	DeleteTemplate(tmplName string) error
}
