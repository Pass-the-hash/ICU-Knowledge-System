<template>

  <v-container
      color="grey darken-2"
      height="800"
  >
    <v-simple-table dark>
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

    <v-card
        class="pa-2"
        outlined
        tile
        dark
        height="900"
    >
      <apexchart :width="700" :options="options" :series="series"></apexchart>
    </v-card>
  </v-container>


</template>

<script>
export default {
  name: "Statistics",
  props: {
    patient: Object,
    information: Object
  },
  data: () =>({
    options: {
      chart: {
        id: 'vuechart-example',
        foreColor: '#ebf4f7',
        height: 90,
        type: 'scatter',
        fill: {
          opacity: 0.8
        },
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
            color: '#255aee',
            shadeTo: 'light',
            shadeIntensity: 0.65
        },
      }
      /*xaxis: {
        categories: []
      },*/
    },
    series: [],

  }),
  /*watch:{

  },*/
  methods: {

    updateChart() {


     // const colors = ['#008FFB', '#00E396', '#FEB019', '#FF4560', '#775DD0']
      this.series = [
        {
          name: 'Πίεση παρεχόμενου οξυγόνου',
          data: this.information.PaO2
        },
        {
          name: 'Ποσοστό παρεχόμενου οξυγόνου',
          data: this.information.FiO2
        },
        {
          name: 'Αιμοπετάλια',
          data: this.information.PLT
        },
        {
          name: 'Κρεατινίνη',
          data: this.information.CR
        },
        {
          name: 'Χολυρεθρίνη',
          data: this.information.BIL
        }
      ]

      // Make sure to update the whole options config and not just a single property to allow the Vue watch catch the change.
      this.options = {
        //colors: [colors[Math.floor(Math.random()*colors.length)]],

        series: this.series,

        xaxis: {
          tickAmount: 12,
          type: 'category',
          categories: this.information.dates,
        },
        yaxis: {
          max: 800
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