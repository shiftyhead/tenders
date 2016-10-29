// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require 3rd-party/jquery/jquery-3.1.0.min.js
//= require 3rd-party/jquery/jquery-ui-1.8.min.js
//= require 3rd-party/jqueryvalidate/jquery.validate.js
//= require 3rd-party/datetimepicker/jquery.datetimepicker.full.js
//= require 3rd-party/circleProgressJQuery.js
//= require moment

function additionalField() {
  $('.js-add').on('click', function() {
    var newField = '<div class="x-form__field-wrapper"><div class="x-form__field-inner"><input class="x-form__field js-autocomplete" name="regionName[]"></div><div class="x-form__field-button x-form__field-button--remove js-remove"></div></div>'
    $('.x-form__field-wrapper').last().after(newField)
    $('.js-remove').on('click', function() {
      $(this).parent().remove()
    })
  })
}

function autocompleteRegion() {
  var regions = [
    'Адыгея респ.',
    'Алтай респ.',
    'Башкортостан респ.',
    'Бурятия респ.',
    'Дагестан респ.',
    'Ингушетия респ.',
    'Кабардино-Балкарская респ.',
    'Калмыкия респ.',
    'Карачаево-Черкесская респ.',
    'Карелия респ.',
    'Коми респ.',
    'Марий Эл респ.',
    'Мордовия респ.',
    'Саха (Якутия)',
    'Северная Осетия — Алания',
    'Татарстан респ.',
    'Тыва (Тува) респ.',
    'Удмуртская респ.',
    'Хакасия респ.',
    'Чеченская респ.',
    'Чувашская респ.',
    'Автономная республика Крым',
    'Алтайский край',
    'Забайкальский край',
    'Камчатский край',
    'Краснодарский край',
    'Красноярский край',
    'Пермский край',
    'Приморский край',
    'Ставропольский край',
    'Хабаровский край',
    'Амурская обл.',
    'Архангельская обл.',
    'Астраханская обл.',
    'Белгородская обл.',
    'Брянская обл.',
    'Владимирская обл.',
    'Волгоградская обл.',
    'Вологодская обл.',
    'Воронежская обл.',
    'Ивановская обл.',
    'Иркутская обл.',
    'Калининградская обл.',
    'Калужская обл.',
    'Кемеровская обл.',
    'Кировская обл.',
    'Костромская обл.',
    'Курганская обл.',
    'Курская обл.',
    'Ленинградская обл.',
    'Липецкая обл.',
    'Магаданская обл.',
    'Московская обл.',
    'Мурманская обл.',
    'Нижегородская обл.',
    'Новгородская обл.',
    'Новосибирская обл.',
    'Омская обл.',
    'Оренбургская обл.',
    'Орловская обл.',
    'Пензенская обл.',
    'Псковская обл.',
    'Ростовская обл.',
    'Рязанская обл.',
    'Самарская обл.',
    'Саратовская обл.',
    'Сахалинская обл.',
    'Свердловская обл.',
    'Смоленская обл.',
    'Тамбовская обл.',
    'Тверская обл.',
    'Томская обл.',
    'Тульская обл.',
    'Тюменская обл.',
    'Ульяновская обл.',
    'Челябинская обл.',
    'Ярославская обл.',
    'Москва',
    'Санкт-Петербург',
    'Севастополь',
    'Еврейская авт. обл.',
    'Ненецкий авт. окр.',
    'Ханты-Мансийский авт. окр.',
    'Чукотский авт. окр.',
    'Ямало-Ненецкий авт. окр.'
  ]

  $('.js-autocomplete').autocomplete({
    source: regions
  })
}

function drawBubbleChart() {

  var dataForTable = new google.visualization.DataTable();
  dataForTable.addColumn('number', '№');
  dataForTable.addColumn('string', 'Название процедуры');
  dataForTable.addColumn('string', 'Вес*');
  dataForTable.addColumn('string', 'Тип');
  dataForTable.addColumn('string', 'Организатор');
  dataForTable.addColumn('date', 'Опубликовано');
  dataForTable.addColumn('date', 'Актуально до');
  dataForTable.addColumn('number', 'Цена, руб.');

  dataForTable.addRows([
    [135677, 'Закупка крепежных изделий', '75%', 'Аукцион', 'Новокуйбышевс', new Date(2016, 6, 5), new Date(2016, 7, 8), 3000000],
    [134568, 'Гайка на 2017 г.', '53 %', 'Запрос цен', 'Борхиммаш ООО', new Date(2016, 5, 17), new Date(2016, 6, 12), 2500500],
    [135677, 'Закупка крепежных изделий', '75%', 'Аукцион', 'Новокуйбышевс', new Date(2016, 6, 5), new Date(2016, 7, 8), 3000000],
    [134568, 'Гайка на 2017 г.', '53 %', 'Запрос цен', 'Борхиммаш ООО', new Date(2016, 5, 17), new Date(2016, 6, 12), 2500500],
    [135677, 'Закупка крепежных изделий', '75%', 'Аукцион', 'Новокуйбышевс', new Date(2016, 6, 5), new Date(2016, 7, 8), 3000000],
    [134568, 'Гайка на 2017 г.', '53 %', 'Запрос цен', 'Борхиммаш ООО', new Date(2016, 5, 17), new Date(2016, 6, 12), 2500500],
    [135677, 'Закупка крепежных изделий', '75%', 'Аукцион', 'Новокуйбышевс', new Date(2016, 6, 5), new Date(2016, 7, 8), 3000000],
    [134568, 'Гайка на 2017 г.', '53 %', 'Запрос цен', 'Борхиммаш ООО', new Date(2016, 5, 17), new Date(2016, 6, 12), 2500500],
    [135677, 'Закупка крепежных изделий', '75%', 'Аукцион', 'Новокуйбышевс', new Date(2016, 6, 5), new Date(2016, 7, 8), 3000000],
    [134568, 'Гайка на 2017 г.', '53 %', 'Запрос цен', 'Борхиммаш ООО', new Date(2016, 5, 17), new Date(2016, 6, 12), 2500500]
  ]);

  var dataForBubble = google.visualization.arrayToDataTable([
    ['ID', 'Дата', 'Сумма', 'Процедура', 'Доля'],
    ['135677', new Date(2016, 6, 5), 3000000, 'Закупка крепежных изделий', 75],
    ['134568', new Date(2016, 5, 17), 2500500, 'Запрос цен', 53],
    ['134569', new Date(2016, 4, 13), 1000500, 'Запрос цен', 14],
    ['135677', new Date(2015, 6, 5), 3000000, 'Закупка крепежных изделий', 75],
    ['134568', new Date(2015, 5, 17), 2500500, 'Запрос цен', 53],
    ['134569', new Date(2015, 4, 13), 1000500, 'Запрос цен', 14],
    ['135677', new Date(2014, 6, 5), 3000000, 'Закупка крепежных изделий', 75],
    ['134568', new Date(2014, 5, 17), 2500500, 'Запрос цен', 53],
    ['134569', new Date(2014, 4, 13), 1000500, 'Запрос цен', 14],
    ['134569', new Date(2013, 4, 13), 1000500, 'Запрос цен', 14]

  ])

  var optionsBubble = {
    hAxis: {
      title: 'Дата, дни',
      format: 'MMM'
    },
    vAxis: { title: 'Цена контракта, млн. руб.', },
    bubble: {
      textStyle: {
        fontSize: 11
      }
    },
    colorAxis: { colors: ['yellow', 'red'], },
    legend: { position: 'none', },
    chartArea: { left: 50, top: 10, width: '80%', height: '80%' }
  };

  var cssClassNames = {
    tableRow: 'x-table__row',
    hoverTableRow: 'x-table__row--hover',
    tableCell: 'x-table__cell',
    headerCell: 'x-table__head-cell',
    headerRow: 'x-table__head',
    oddTableRow: 'x-table__row'
  }

  var optionsTable = {
    showRowNumber: false,
    height: '300px',
    cssClassNames
  }

  var table = new google.visualization.Table(document.getElementById('table_div'));
  table.draw(dataForTable, optionsTable);

  var bubble = new google.visualization.BubbleChart(document.getElementById('bubble_div'));
  bubble.draw(dataForBubble, optionsBubble);

  var rows = [].slice.call(document.querySelectorAll('.x-table__row'));

  if (window.location.pathname === '/index3.html') {
    var rows = [].slice.call(document.querySelectorAll('.x-table__row'));
    rows.forEach(function(item, index) {
      if (index === 2) {
        item.classList.add('is-active')
      }
    })
  }

  function checkChoice() {
    $('#make-choice').hide()
    $('#go-next').hide()

    if (table.getSelection().length === 0) {
      $('#make-choice').show()
      $('#go-next').hide()
    } else {
      $('#make-choice').hide()
      $('#go-next').show()
    }
  }

  checkChoice()

  google.visualization.events.addListener(table, 'select', function() {
    bubble.setSelection(table.getSelection())
    var currentRowIndex = table.getSelection()

    // номер строки таблицы (индекс), по которой было совершено действие
    if (currentRowIndex.length > 0) {
      currentRowIndex = currentRowIndex[0].row
    }

    checkChoice()

  });

  google.visualization.events.addListener(bubble, 'select', function() {
    table.setSelection(bubble.getSelection());
  });
}

function circleProgressInit() {
  var persentage = 67;

  $('#progress').circleProgress({
    value: persentage / 100,
    size: 100,
    fill: {color: "#fff"},
    emptyFill: "#d9dada",
    startAngle: 0,
    thickness: 10,
    lineCap: "round"
  });
  // Для отображения процентов внутри прогресс-бара
  $('#progress').attr('data-content', persentage + '%');
}

function collapseSettings() {
  var toggle = $('.js-toggle')
  var height = $('.x-settings').outerHeight()
  toggle.on('click', function() {
    if ($('.x-hexagon__corners').hasClass('is-collapsed')){
      $('.x-settings').css('height', '').css('overflow', '')
      $('.x-hexagon__corners').removeClass('is-collapsed')
    } else {
      $('.x-settings').css('height', '80px').css('overflow', 'hidden')
      $('.x-hexagon__corners').addClass('is-collapsed')
    }
  })
}

function datetimepickerInit() {
  // $.datetimepicker.setLocale('ru')

  $('#date_timepicker_start').datetimepicker({
    format: 'd/m/Y',
    onShow: function(ct) {
      this.setOptions({
        maxDate: $('#date_timepicker_end').val() ? $('#date_timepicker_end').val() : false,
        formatDate:'d/m/Y'
      })
    },
    timepicker: false
  })
  $('#date_timepicker_end').datetimepicker({
    format:'d/m/Y',
    onShow: function(ct) {
        this.setOptions({
        minDate: $('#date_timepicker_start').val() ? $('#date_timepicker_start').val() : false,
        formatDate:'d/m/Y'
      })
    },
    timepicker: false
  })
}

//Переменные для круговой диаграммы и легенды
//TODO: добавить нужные цвета
var colorsPieOne = ['#f2cc2f', '#eb5655', '#7ec181', '#4099c6']
var dataArrPieOne = [
  {
    name: 'Категория №1',
    quantity: 174,
    portion: '(от 75%-100% лотов из тендера соответсвует продукции вашей компании)'
  },
  {
    name: 'Категория №2',
    quantity: 133,
    portion: '(от 75%-100% лотов из тендера соответсвует продукции вашей компании)'
  },
  {
    name: 'Категория №3',
    quantity: 307,
    portion: '(от 75%-100% лотов из тендера соответсвует продукции вашей компании)'
  },
  {
    name: 'Категория №4',
    quantity: 410,
    portion: '(от 75%-100% лотов из тендера соответсвует продукции вашей компании)'
  }
]

function drawPieChart() {
// Define the chart to be drawn.
  var data = new google.visualization.DataTable()
  var options = {
          legend: 'none',
          colors: colorsPieOne,
        };
  data.addColumn('string', 'Element')
  data.addColumn('number', 'Percentage')
  data.addRows([
    ['Категория № 1', 174],
    ['Категория № 2', 133],
    ['Категория № 3', 307],
    ['Категория № 4', 410]
  ]);
  // Instantiate and draw the chart.
  var chart = new google.visualization.PieChart(document.getElementById('myPieChart'));
  chart.draw(data, options);
}

function drawLegend(arr, colors) {
  var myHTML = "";
  var template = "<li class='x-legend__item'><div>#quantity# тендеров</div><div><span style='color:#color#'>#name#</span> #portion#</div></li>"
  var temporaryString = "";

  arr.forEach(function(item, index) {
    temporaryString = template;
    temporaryString = temporaryString.replace("#color#", colors[index]);
    temporaryString = temporaryString.replace("#quantity#", arr[index].quantity);
    temporaryString = temporaryString.replace("#name#", arr[index].name);
    temporaryString = temporaryString.replace("#portion#", arr[index].portion);

    myHTML += temporaryString;
  })

  var myList = document.getElementsByClassName('x-legend__list')[0];
  myList.innerHTML = myHTML;
}


function drawPieChartTwo() {
// Define the chart to be drawn.
  var data = new google.visualization.DataTable()
  //TODO: добавить нужные цвета
  var colorsPieTwo = ['#77c9d7', '#addbe0', '#43777c']
  var options = {
    colors: colorsPieTwo,
    chartArea: {
      left: 40,
      top: 10,
      width:'90%',
      height:'90%'
    }
  };
  data.addColumn('string', 'Категория')
  data.addColumn('number', 'Доля')
  data.addRows([
    ['Борхиммаш ОАО', 15],
    ['Новокуйбышевский НПЗ ОАО', 43],
    ['Сибнефтегаз ОАО', 76]
  ]);
  // Instantiate and draw the chart.

  var dataForTable = new google.visualization.DataTable();
  dataForTable.addColumn('string', 'Наименование организации');
  dataForTable.addColumn('string', 'Регион');
  dataForTable.addColumn('number', 'Всего тендеров');
  dataForTable.addColumn('number', 'Частота (тенд./мес.)');

  dataForTable.addRows([
    ['Борхиммаш ОАО', 'Воронежская обл.', 15, 0.9],
    ['Новокуйбышевский НПЗ ОАО', 'Самарская обл.', 43, 3.6],
    ['Сибнефтегаз ОАО', 'Ямало-Ненецкий АО', 76, 6.3]
  ]);

  var cssClassNames = {
    tableRow: 'x-table__row',
    hoverTableRow: 'x-table__row--hover',
    tableCell: 'x-table__cell',
    headerCell: 'x-table__head-cell',
    headerRow: 'x-table__head',
    oddTableRow: 'x-table__row'
  };

  var optionsTable = {
    showRowNumber: false,
    height: '300px',
    cssClassNames
  };

  var table = new google.visualization.Table(document.getElementById('table-for-piechart'));
  table.draw(dataForTable, optionsTable);

  var chart = new google.visualization.PieChart(document.getElementById('piechartTwo'));
  chart.draw(data, options);

  google.visualization.events.addListener(table, 'select', function() {
    chart.setSelection(table.getSelection());
  });

  google.visualization.events.addListener(chart, 'select', function() {
    table.setSelection(chart.getSelection());
  });

}

$(document).ready(function() {
  datetimepickerInit()
  additionalField()
  validationForm()
  autocompleteRegion()
  $('.js-add').on('click', autocompleteRegion)
  collapseSettings();
  google.charts.load('current', {'packages': ['table', 'corechart'], 'language': 'ru'});
  if (document.querySelector('#myPieChart')) {
    google.charts.setOnLoadCallback(drawPieChart)
    drawLegend(dataArrPieOne, colorsPieOne);
  }
  if (document.querySelector('#table_div')) {
    google.charts.setOnLoadCallback(drawBubbleChart);
  }
  circleProgressInit();
  if (document.querySelector('#piechartTwo')) {
    google.charts.setOnLoadCallback(drawPieChartTwo)
  }
});

function validationForm() {
  $(".x-form").validate({
    rules: {
      companyName: {
        required: true
      },
      productName: {
        required: true
      },
      dateFrom: {
        required: true
      },
      dateTo: {
        required: true
      },
      'regionName[]': {
        required: true
      }
    },

    messages: {
      companyName: {
        required: "Обязательно для заполнения"
      },
      productName: {
        required: "Обязательно для заполнения"
      },
      dateFrom: {
        required: "Введите дату"
      },
      dateTo: {
        required: "Введите дату"
      },
      'regionName[]': {
        required: "Обязательно для заполнения"
      }
    }
  })
}
