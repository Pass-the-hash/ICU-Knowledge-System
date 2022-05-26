<template>

  <div >
    <v-simple-table>
    <template v-slot:default>
      <thead>
      <tr>
        <th class="text-left">
          Name
        </th>
        <th class="text-left">
          Data
        </th>
      </tr>
      </thead>
      <tbody>
      <tr
          v-for="item in series"
          :key="item.name"
      >
        <td>{{ item.name }}</td>
        <td>{{ item.data }}</td>
      </tr>
      </tbody>
    </template>
  </v-simple-table>
    <v-container
      class="d-flex mb-6"
      tile
      align="left"
    >
        <apexchart class="py-10" width="600" height="500" :options="options" :series="series" ></apexchart>
    </v-container>
    </div>
</template>

<script>
export default {
  name: "Statistics",
  props: {
    patient: Object,
    information: {
      type: Object,
      required: true
    },
  },
  data: () =>({
    options: {
      chart: {
        id: 'vuechart-example',
        foreColor: 'black',
        height: 300,
        // type: 'line',

        zoom: {
          type: 'xy'
        }
      },
      title: {
        text: 'Στατιστικά στοιχεία ασθενή',
        align: 'left'
      },
      theme: {
        mode: 'light',
        palette: 'palette4',
        monochrome: {
            enabled: false,
            color: 'black',
            shadeIntensity: 0.65
        },
      },
      /*xaxis: {
        labels: {
          datetimeFormatter: {
            year: 'yyyy',
            month: 'MMM \'yy',
            day: 'dd MMM',
            hour: 'HH:mm'
          }
        }
      }*/
    },
    series: [],

  }),
  methods: {
    updateChart() {
     // const colors = ['#008FFB', '#00E396', '#FEB019', '#FF4560', '#775DD0']
      this.series = [
        {
          type: 'line',
          name: 'Πίεση παρεχόμενου οξυγόνου',
          data: this.information.PaO2
        },
        {
          type: 'line',
          name: 'Ποσοστό παρεχόμενου οξυγόνου',
          data: this.information.FiO2
        },
        {
          type: 'line',
          name: 'Αιμοπετάλια',
          data: this.information.PLT
        },
        {
          type: 'line',
          name: 'Κρεατινίνη',
          data: this.information.CR
        },
        {
          type: 'line',
          name: 'Χολυρεθρίνη',
          data: this.information.BIL
        }
      ]
      // Make sure to update the whole options config and not just a single property to allow the Vue watch catch the change.
      this.options = {
        //colors: [colors[Math.floor(Math.random()*colors.length)]],
        series: this.series,
        xaxis: {
          type: 'datetime',
          categories: this.information.dates,
        },
        tooltip: {
          x: {
            format: 'dd MMM yyyy'
          }
        },
        yaxis: {
          max: 400
        },
        responsive: [{
          breakpoint: 480,
          options: {
            legend: {
              position: 'bottom',
              offsetX: -10,
              offsetY: 0
            }
          }
        }],
        /*plotOptions: {
          bar: {
            horizontal: false,
            borderRadius: 10
          },
        },*/
        legend: {
          position: 'right',
          offsetY: 40
        }
      };
      // In the same way, update the series option
    }
  },
   mounted() {
    // this.show()
     this.updateChart()
  }
}
</script>

<style scoped>
h1 {
  text-align: center;
}
</style>