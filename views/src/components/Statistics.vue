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
        type: 'line',

        zoom: {
          type: 'xy'
        }
      },
      title: {
        text: 'Στατιστικά στοιχεία ασθενή',
        align: 'left'
      },
    },
    series: [],

  }),
  methods: {
    updateChart() {
      const colors = ['#4ecdc4',	'#c7f464',	'#546E7A',	'#FF9800', '#3f51b5',  '#fd6a6a']
      this.series = [
        {
          name: 'Πίεση οξυγόνου στις αρτηρίες',
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
        },
        {
          name: 'Μέση αρτηριακή πίεση',
          data: this.information.MAP
        }
      ]
      // Make sure to update the whole options config and not just a single property to allow the Vue watch catch the change.
      this.options = {
        //colors: [colors[Math.floor(Math.random()*colors.length)]],
        series: this.series,
        xaxis: {
          type: 'category',
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
        colors: colors,
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