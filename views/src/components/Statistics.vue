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
      <apexchart width="700" type="bar" :options="options" :series="series"></apexchart>
    </v-card>
  </v-container>


</template>

<script>
// import axios from "axios";

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
        height: 350,
        stacked: true,
        toolbar: {
          show: false
        },
        zoom: {
          enabled: false
        }
      },
      title: {
        text: 'Στατιστικά στοιχεία ασθενή',
        align: 'left'
      },
      xaxis: {
        categories: []
      },
      labels: []
    },
    series: [],

  }),
  /*watch:{

  },*/
  methods: {

    updateChart() {

     // const colors = ['#008FFB', '#00E396', '#FEB019', '#FF4560', '#775DD0']

      // Make sure to update the whole options config and not just a single property to allow the Vue watch catch the change.
      this.options = {
        //colors: [colors[Math.floor(Math.random()*colors.length)]],
        xaxis: {
          categories: this.information.dates
        },
        yaxis: {
          max: 100
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
        plotOptions: {
          bar: {
            horizontal: false,
            borderRadius: 10
          },
        },
        legend: {
          position: 'right',
          offsetY: 40
        },
        fill: {
          opacity: 1
        }
      };
      // In the same way, update the series option
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
          name: 'Κρεατινίνη',
          data: this.information.CR
        },
        {
          name: 'Χολυρεθρίνη',
          data: this.information.BIL
        },
        {
          name: 'Αιμοπετάλια',
          data: this.information.PLT
        }
      ]
    }
  },
   created() {
    // this.show()
     console.log(this.information)
     this.updateChart()
  }
}
</script>

<style scoped>
h1 {
  text-align: center;
}
</style>