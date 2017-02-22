export class Tab {
  constructor(element, data) {
    var graph = require('flot_graph');

    this.$element = $(element);
    this.graphs = $('.graph-container', this.$element).map(function(_index, e) {
      return new graph.Graph($('.graph', e), $(e).data('graph-data'), $(e).data('graph-options'));
    });
    this.activate();
  }

  // Flot won't initialize unless the graph container is visible. So activate the
  // graph on tab switch
  activate() {
    this.tab_control().on('hide.bs.tab', e => {
      this.hide();
    });

    this.tab_control().on('shown.bs.tab', e => {
      e.preventDefault();
      $(this).tab('show');
      this.show();
    });
  }

  tab_control() {
    return $('a[data-toggle="tab"][aria-controls=' + this.$element.attr('id') + ']');
  }

  hide() {
    $.each(this.graphs, function(_index, graph) { graph.shutdown(); });
    return true;
  }

  show() {
    $.each(this.graphs, function(_index, graph) { graph.activate(); });
  }
}
